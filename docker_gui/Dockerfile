# Utiliza una imagen base que contenga un servidor de ventanas X (X11)
FROM jlesage/baseimage-gui:alpine-3.15-v4.5

# Instala un navegador web para este ejemplo
RUN apk --no-cache add firefox-esr

# Configura el entorno
ENV APP_NAME="Firefox"

# Ejecuta el navegador web al inicio del contenedor
CMD ["/startup.sh"]
