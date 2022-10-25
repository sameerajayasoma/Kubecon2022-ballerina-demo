import ballerina/io;
import ballerina/http;

public type GroupEntity record {
    readonly int id;
    string title;
    string description;
    string createdAt;
    string updatedAt;
};

public type GroupRequest record {
    string title;
    string description;
};

public type GroupResponse record {
    int id;
    string title;
    string description;
    string createdAt;
    string updatedAt;
};

table<GroupEntity> key(id) groups = table [];

@display {
    label: "GroupService",
    id: "GroupService"
}
service / on new http:Listener(8080) {
    resource function get groups() returns GroupResponse[]|error {
        io:println("11111");
        return [{id:1234, title: "foo", description: "fff", createdAt: "Ddd", updatedAt: "ddd"}];
    }

    resource function get groups/[int groupId]() returns GroupResponse|error{
        return {id:1234, title: "foo", description: "fff", createdAt: "Ddd", updatedAt: "ddd"};
    }

    resource function post groups(@http:Payload GroupRequest groupRequest) returns GroupResponse | error{
        return {id:1234, title: "foo", description: "fff", createdAt: "Ddd", updatedAt: "ddd"};
    }
}
