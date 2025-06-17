# Etapa 1: Build Angular App
FROM node:18-alpine as builder

# Crear directorio de trabajo
WORKDIR /app

# Copiar los archivos del proyecto
COPY . .

# Instalar dependencias
RUN npm install

# Construir la aplicación Angular
RUN npm run build --prod

# Etapa 2: Imagen Nginx para servir los archivos estáticos
FROM nginx:alpine

# Copiar el build al directorio estándar de Nginx
COPY --from=builder /app/dist/mi-app /usr/share/nginx/html

# Cambiar el puerto (opcional)
# Esto edita el archivo de configuración default de nginx para usar el puerto 8080
RUN sed -i 's/listen       80;/listen       8080;/' /etc/nginx/conf.d/default.conf

# Exponer el puerto (coincide con el configurado arriba)
EXPOSE 8080

# Iniciar Nginx en modo foreground
CMD ["nginx", "-g", "daemon off;"]
