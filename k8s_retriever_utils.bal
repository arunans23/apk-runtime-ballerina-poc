import ballerina/http;
import ballerina/os;
import ballerina/log;

final string k8sApiServerUrl = os:getEnv("K8S_API_SERVER_URL");
final string k8sApiToken = os:getEnv("K8S_SERVICE_TOKEN");
const string K8S_API_ENDPOINT = "/api/v1";

final http:Client k8sApiServerEp = check getK8sApiClient();

function getK8sApiClient() returns http:Client|error {
    http:Client k8sApiClient = check new (k8sApiServerUrl + K8S_API_ENDPOINT, 
        auth = {
        token: k8sApiToken
    }
    );
    return k8sApiClient;
}

isolated function getServicesListFromK8s(string namespace) returns ServiceList|error {
    Service[] serviceNames = [];
    string endpoint = "namespaces/" + namespace + "/services";
    error|json serviceResp = k8sApiServerEp->get(endpoint, targetType = json);
    if (serviceResp is json) {
        json[] serviceArr = <json[]>check serviceResp.items;
        foreach json i in serviceArr {
            Service serviceData = {
                 name: <string>check i.metadata.name,
                 namespace: <string>check i.metadata.namespace,
                 'type: <string>check i.spec.'type
            };
            serviceNames.push(serviceData);
        }
        ServiceList serviceList = {
            list: serviceNames
        };
        return serviceList;
    } else {
        log:printError(serviceResp.message());
    }
    return error("error while retrieving service list from K8s API server for namespace : " + namespace);
}