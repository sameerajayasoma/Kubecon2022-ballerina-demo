import ballerina/http;

configurable string taskGroupServiceUrl = ?;
configurable string taskServiceUrl = ?;

type Group record {
    int id;
    string title;
    string description;
    string createdAt;
    string updatedAt;
};

type Task record {
    int id;
    string title;
    string description;
    int groupId;
    string status;
    string createdAt;
    string updatedAt;
};

public type TaskRequest record {
    string title;
    string description;
    int groupId?;
    string status;
    string createdAt;
    string updatedAt;
};

service / on new http:Listener(8090) {
    resource function get tasks(string? groupTitle, string? taskStatus) returns Task[]|error {
        http:Client taskEp = check new (taskServiceUrl);
        Task[] tasks;
        if groupTitle is () {
            // groupTitle query param is not specified
            tasks = check taskEp->get("/tasks");
        } else {
            // Type narrowing groupTitle is string == true
            http:Client taskGroupEp = check new (taskGroupServiceUrl);
            Group[] allGroups = check taskGroupEp->get("/groups");
            int[] groupIds = from var {id, title} in allGroups
                where title == groupTitle
                limit 1
                select id;

            if groupIds.length() == 0 {
                return error(string `Cannot find a group with title: ${groupTitle}`);
            }
            tasks = check taskEp->get(string `/tasks?groupId=${groupIds[0]}`);
        }
        return tasks;
    }

    resource function get tasks/[string taskId]() returns Task[]|error {
        return error("Not implemented");
    }

    resource function post tasks(@http:Payload TaskRequest taskReq) returns Task|error {
        return error("Not implemented");
    }

    resource function delete tasks/[string taskId]() returns Task[]|error {
        return error("Not implemented");
    }
}
