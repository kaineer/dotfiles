## Причины по которым может свалиться ansible-galaxy

 * Каталог ~/.ansible/roles внезапно стал принадлежать root 
   * Произойти это могло из-за того, что кто-то запустил ./bin/dotfiles.sh через sudo
   * Не надо так
   * [Как исправить]: Заходим в каталог ~/.ansible, делаем sudo chown -R username:username

## TODO

 * starship
 * fzf
