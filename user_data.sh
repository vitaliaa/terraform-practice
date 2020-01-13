sudo apt -y update
sudo apt -y install apache2
echo "<h1>Hello world!!!</h1>" > /var/www/html/index.html
sudo systemctl apache2 restart

