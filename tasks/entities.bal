
type TaskEntity record {|
    readonly int id;
    string title;
    string description;
    int groupId;
    string status;
    string createdAt;
    string updatedAt;
|};

table<TaskEntity> key(id) tasks = table [];
