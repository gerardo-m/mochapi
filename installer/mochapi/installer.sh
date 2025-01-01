echo ""
echo "███    ███  ██████   ██████ ██   ██  █████  ██████  ██ "
echo "████  ████ ██    ██ ██      ██   ██ ██   ██ ██   ██ ██ "
echo "██ ████ ██ ██    ██ ██      ███████ ███████ ██████  ██ "
echo "██  ██  ██ ██    ██ ██      ██   ██ ██   ██ ██      ██ "
echo "██      ██  ██████   ██████ ██   ██ ██   ██ ██      ██ "
echo "                                                       "

echo "Welcome to the MOCHAPI installer"
echo -e "This installer will only create an .env file based on your answers.\n"
echo -e "If you made a mistake just re-run the installer."

now=$(date)
rm -f -- .env
echo "# Mochapi env file" >> .env
echo "# Created ${now}" >> .env

echo ""
echo "Setting up mysql Database"
echo -e "\n[mysql] Provide a password for the root user."
printf "[mysql] root user password: "
read ROOT_PASSWORD

while [[ -z "$ROOT_PASSWORD" ]];
do
	echo -e "\n[mysql] Please enter a non blank password."
	printf "\n[mysql] root password: "
	read ROOT_PASSWORD
done
echo "MYSQL_ROOT_PASSWORD=${ROOT_PASSWORD}" >> .env

echo -e "\n[mysql] Provide a password for the mochapi user."
echo -e "[mysql] That is the user that the app will use to interact with the db"
printf "[mysql] mochapi user password: "
read MOCHAPI_PASSWORD

while [[ -z "$MOCHAPI_PASSWORD" ]];
do
	echo -e "\n[mysql] Please enter a non blank password."
	printf "\n[mysql] mochapi password: "
	read MOCHAPI_PASSWORD
done
echo "MYSQL_PASSWORD=${MOCHAPI_PASSWORD}" >> .env
echo "MOCHAPI_DATABASE_PASSWORD=${MOCHAPI_PASSWORD}" >> .env

echo ""
echo "Creating rails secret key"

SECRET="$(xxd -l64 -ps -c64 /dev/urandom)"
echo "SECRET_KEY_BASE=${SECRET}" >> .env

echo "Generated secret ${SECRET}"
echo ""
echo "You are all set, just run docker compose up -d to deploy"

