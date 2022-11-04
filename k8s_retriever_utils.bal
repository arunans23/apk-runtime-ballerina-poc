import ballerina/http;
import ballerina/os;

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