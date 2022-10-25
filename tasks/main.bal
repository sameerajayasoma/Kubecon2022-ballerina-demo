import ballerina/http;

// Had to make it public, otherwise HTTP compiler plugin throws warnings
public type TaskRequest record {
    string title;
    string description;
    int groupId?; // If the groupId is empty, then the "Inbox" group is assigned. That is the default group.
    string status?;
};

public type TaskResponse record {|
    int id;
    string title;
    string description;
    int groupId;
    string status;
    string createdAt;
    string updatedAt;
|};

@display {
    label: "TasksService",
    id: "TasksService"
}
service / on new http:Listener(9090) {
    resource function post tasks(@http:Payload TaskRequest taskRequest) returns TaskResponse|error {
        return {id: 3333, title: "foobar", description: "Test task", groupId: 1234, status: "Open", createdAt: "today", updatedAt: "yesterday"};
    }

    resource function get tasks/[string taskId]() returns TaskResponse|error {
        return {id: 3333, title: "foobar", description: "Test task", groupId: 1234, status: "Open", createdAt: "today", updatedAt: "yesterday"};
    }

    resource function get tasks(string? groupId) returns TaskResponse[]|error {
        return [{id: 3333, title: "foobar",description: "Test task", groupId: 1234, status: "Open", createdAt: "today", updatedAt: "yesterday"}];
    }

    resource function put tasks/[string taskId](@http:Payload TaskRequest taskRequest) returns TaskResponse|error {
        return {id: 3333, title: "foobar", description: "Test task", groupId: 1234, status: "Open", createdAt: "today", updatedAt: "yesterday"};
    }
}
