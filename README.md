# Strapi Blog

A full-stack blog application built with Strapi CMS and Next.js, containerized with Docker.

## 🚀 Tech Stack

- **Backend**: Strapi v5.17.0 (Headless CMS)
- **Frontend**: Next.js 15.3.5 with React 19
- **Database**: PostgreSQL 16
- **Containerization**: Docker & Docker Compose
- **Language**: TypeScript

## 📁 Project Structure

```
strapi-blog/
├── nextjs/          # Next.js frontend application
├── strapi/          # Strapi CMS backend
├── docker-compose.yml
└── environment files
```

## 🛠️ Prerequisites

- Docker and Docker Compose
- Node.js 18+ (for local development)
- npm 6+
- openssl (for recommended first setup)

## ⚡ Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/Aksars/strapi-blog.git
   cd strapi-blog
   ```

2. **Set up environment variables**  
  **Use setup.sh** script to generate passwords for DB and all Strapi keys using openssl rand -base64 32 **(recommended)**  
   **Run**
   ```bash
   ./setup.sh
   ```  
   You can generate passwords for DB and keys on your own from examples by doing something like this instead of using setup.sh:
   ```bash
   rename .example.env.* files to .env.*
   mv .example.env.db .env.db
   mv .example.env.strapi .env.strapi
   mv .example.env.nextjs .env.nextjs
   #change db password in .env.db for yours
   #generate keys by yourself in .env.strapi
   ```   

3. **Start the application**  
   Run docker-compose to get things running (takes about 60 seconds)
   ```bash
   docker-compose up -d
   ```
   If you are using VS Code, you can install dependencies in ./nextjs with npm install to get rid of linter warnings (it works well without it)

4. **Access the applications**  
   If you access from the same machine, use:  
   - Frontend: http://localhost:3000
   - Strapi Admin: http://localhost:1337/admin
   - Database: localhost:5432  

   Or if you develop on a VPS, insert its IP like:  
   - Frontend: http://111.222.222.222:3000 to access your project    

   **First run of Strapi admin page takes about 15 seconds on my VPS, so be patient**

5. **Development**  
   You can change files in ./nextjs to edit the frontend.  
   **Try to write something in**   
   ```
   /nextjs/src/app/page.tsx
   ```
   to see the changes instantly on http://localhost:3000.
   Docker volume and Next.js will handle this. The same goes for Strapi.  

   If you need to restart the project, use:

    ```bash
   docker-compose down
   docker-compose up -d
   ```

## 🐳 Docker Services

- **postgres**: PostgreSQL database
- **strapi**: Strapi CMS backend
- **nextjs**: Next.js frontend

## 📚 Available Scripts

### in development

## 🔍 Health Checks

The application includes health checks for:
- PostgreSQL database connectivity
- Strapi API availability

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📄 License

This project is licensed under the MIT License.