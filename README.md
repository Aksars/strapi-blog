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
- openssl (for first setup)

## ⚡ Quick Start

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd strapi-blog-main
   ```

2. **Set up environment variables**
  use setup.sh script to generate pass for DB and all strapi keys using openssl rand -base64 32 (recomended) 
   **Just run**
   ```bash
   ./setup.sh
   ```
   You can generete password for db and keys on your own from examples doing something like this instaed of setup.sh
   ```bash
   rename .example.env.* files to .env.*
   mv .example.env.db .env.db
   mv .example.env.strapi .env.strapi
   mv .example.env.nextjs .env.nextjs
   #change db password in .env.db for yours
   #generate keys by yourself in .env.strapi
   ```   

3. **Start the application**
   Run docker-compose to get things running (near 60s)
   ```bash
   docker-compose up -d
   ```
   if you are using vs code you can install dependencies in ./next.js with npm install just to get rid of linter warnings (it works well without it)

4. **Access the applications**
   if you access from same machine use
   - Frontend: http://localhost:3000
   - Strapi Admin: http://localhost:1337/admin
   - Database: localhost:5432
   or if you develop on some VPS insert its IP like 
   - Frontend: http://111.222.222.222:3000 to access your project 
   - ... 

   First run of strapi admin page takes near 15s on my VPS so be paitent

5. **Development**
   You can change files in ./nextjs to edit frontend.
   Try to write something in 
   /nextjs/src/app/page.tsx
   to see the changes instatnly on http://localhost:3000. 
   Docker volume and next will handle it
   Same gouse for Strapi. 
   If you need to restart project use 
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