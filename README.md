# UsersGithubRepositories
SwiftUI app to display GitHub repositories for specific user with ability to star and store it locally.

## How it works
App allows users to search GitHub repositories for specific username.
1. On main page there are two tabs: 1. Repositories list and 2. Starred repositories.
2. App user needs to enter username in search field and return to find repositories of specific user.
> With minor change in the app, search can be executed, every time user changes text. (Indicated and commented out in the app)
4. User's repositories are fetched and displayed in the list.
5. Through the list user can navigate to repository details page.
6. On repository details page, app user can open repository link in web.
7. On repository details page, app user can 'star'/'unstar' repository.
8. Repository starring and persistence is done locally on the phone.
9. On Starred repositories tab, user can see the list and details of already starred different repositories

## Development
- App architecture is MVVM
- App UI is implemented using SwiftUI.
- Networking and ViewModels are implemented using Combine framework.
- Data is fetched using [GitHub API](https://docs.github.com/en/rest)
- UserDefaults is used for persistence.
