# Pipedrive test task

Unfortunately, due to lack of time, this code is kind of unfinished.
Some points that I want to change and improve:
Add better error handling, for example support of localizedDescription for custom errors.
Add UI indicator for not available network status.
Add proper image handling, most probably just use some library, like Kingfisher.

While working on such a project, I would like to add also the following features: connect a database for storing data regardless of the cache's lifetime and add tests. 
Additionally, for user convenience, I would like to include the ability to search, add custom photos and edit person data. And improve UI of course, this UI seems to be not so nice and convinient.

As for the task itself, I think it would be helpful to specify which version of the API should be used, as v1 differs quite a bit from v2. 
Another nice thing to know is minimum iOS version, because if it will be required to support old iOS apps, before iOS 16, most probably using SwiftUI is not a good idea.
Also, the API documentation seems to be lacking in completeness: there’s no information about which fields are optional and which are required. 
This might be because the API is not designed for mobile developers and is likely intended to be interacted with using JS.
