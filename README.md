# MySCM Docker Environment
- React: http://localhost
- Angular: http://localhost:81
- Symfony 3.4 (API): http://localhost:82
- Symfony 5.4 (External API): http://localhost:83
- Mailtrap: http://localhost:84
- Dbgate: http://localhost:85

### ENV variables
- `MYSQL_DATABASE` - app main database
- `MYSQL_USER` - app main database user
- `MYSQL_PASSWORD` - app main database user password
- `MYSQL_ROOT_PASSWORD` - root database user password
- `XDEBUG` - enable xdebug
- `REACT_PATH=../myscm-frontend-react`
- `ANGULAR_PATH=../myfm-frontend/app`
- `API_PATH=../myfm`
- `EDI_PATH=../myscm-api-edi`

### Folder structure
- `/.docker` - docker configuration files
- `/api` - Symfony 3.4 API for MySCM app
- `/edi` - External EDI API
- `/react` - React app for MySCM app
- `/angular` - Angular app for MySCM app

# Commands
     —— 🎵 🐳 The Symfony Docker Makefile 🐳 🎵 ——————————————————————————————————
    help                           Outputs this help screen
     —— Docker 🐳 ————————————————————————————————————————————————————————————————
    build                          Builds the Docker images
    up                             Start the docker hub in detached mode (no logs)
    start                          Build and start the containers
    down                           Stop the docker hub
    logs                           Show live logs
    sh                             Connect to the PHP FPM container
     —— Composer 🧙 ——————————————————————————————————————————————————————————————
    composer                       Run composer, pass the parameter "c=" to run a given command, example: make composer c='req symfony/orm-pack'
    vendor                         Install vendors according to the current composer.lock file
     —— Symfony 🎵 ———————————————————————————————————————————————————————————————
    sf                             List all Symfony commands or pass the parameter "c=" to run a given command, example: make sf c=about
    cc                             Clear the cache


### TODO
- [ ] Make EDI API work
- [ ] Make Angular app work
- [ ] Make React app work
- [ ] Fix bug if filename is not app.php in Symfony 3.4 API returns 404
