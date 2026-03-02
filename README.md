# DevOps CI/CD Mini Project (Jenkins + Docker + Integration Test)

## Overview

A mini project demonstrating a CI/CD pipeline for a Node.js API using:

- **Jenkins** — automated pipeline (checkout → install → test → build → deploy → integration test)
- **Docker / Docker Compose** — reproducible containerised environment
- **Bash & Python automation scripts** — health checks, service readiness, log collection
- **Unit tests** — Jest + Supertest
- **Integration tests** — curl-based bash script + Postman/Newman-ready collection

---

## Project Structure

```
devops-ci-cd-mini-project/
├─ src/
│  └─ app.js                              # Express API
├─ tests/
│  ├─ unit/
│  │  └─ app.test.js                      # Jest unit tests
│  └─ integration/
│     ├─ postman_collection.json          # Newman-runnable collection
│     └─ integration_test.sh             # Bash integration tests
├─ scripts/
│  ├─ healthcheck.sh                     # Retry-based health check (bash)
│  ├─ collect_logs.sh                    # Collect docker compose logs
│  └─ wait_for_app.py                    # Readiness wait (Python)
├─ Dockerfile
├─ docker-compose.yml
├─ Jenkinsfile
├─ package.json
├─ .dockerignore
├─ .gitignore
└─ README.md
```

---

## Tech Stack

| Layer             | Technology              |
|-------------------|-------------------------|
| API               | Node.js + Express       |
| Unit tests        | Jest + Supertest        |
| Containerisation  | Docker / Docker Compose |
| CI/CD pipeline    | Jenkins (Jenkinsfile)   |
| Automation scripts| Bash + Python 3         |
| Integration tests | curl + Postman/Newman   |

---

## API Endpoints

| Method | Endpoint       | Description                        |
|--------|----------------|------------------------------------|
| GET    | `/health`      | Returns service health status      |
| GET    | `/api/version` | Returns the current app version    |
| POST   | `/api/echo`    | Echoes back the sent JSON body     |

---

## Pipeline Stages (Jenkinsfile)

1. **Checkout** — pull source from SCM
2. **Node Version** — verify toolchain
3. **Install Dependencies** — `npm ci`
4. **Unit Tests** — `npm run test:unit`
5. **Build Docker Image** — `docker build`
6. **Start App (Docker Compose)** — `docker compose up -d`
7. **Wait for Health** — Python readiness script (60 s timeout)
8. **Integration Tests** — bash curl-based test suite
9. **Post / Always** — collect logs, archive artifacts, `docker compose down`

---

## Run Locally

### Prerequisites

- Node.js 20+
- npm 9+

```bash
npm install
npm test          # run unit tests
npm start         # start app on port 3000
```

---

## Run with Docker

```bash
docker compose up --build
```

App available at: `http://localhost:3000`

---

## Integration Test (Local)

```bash
# Make sure the app is already running (npm start or docker compose up)
bash tests/integration/integration_test.sh
```

### Run with Newman (Postman CLI)

```bash
npm install -g newman
newman run tests/integration/postman_collection.json \
  --env-var baseUrl=http://localhost:3000
```

---

## Scripts

| Script                      | Purpose                              |
|-----------------------------|--------------------------------------|
| `scripts/healthcheck.sh`    | Retry loop until `/health` responds  |
| `scripts/collect_logs.sh`   | Dump docker compose logs to file     |
| `scripts/wait_for_app.py`   | Python readiness wait with timeout   |

---

## Start Jenkins (Docker)

```bash
# Windows PowerShell
docker run -d --name jenkins `
  -p 8080:8080 -p 50000:50000 `
  -v jenkins_home:/var/jenkins_home `
  -v /var/run/docker.sock:/var/run/docker.sock `
  jenkins/jenkins:lts
```

Then open `http://localhost:8080`, configure pipeline pointing to this repo's `Jenkinsfile`.

---

## Notes

This project is built as a DevOps/Automation practice project for internship applications, focusing on CI/CD, integration testing, and pipeline troubleshooting.

---

## CV Bullets

- Built a **Jenkins-based CI/CD pipeline** for a Node.js API with stages for checkout, dependency installation, unit testing, Docker image build, service startup, and integration testing.
- Wrote **Python and Bash automation scripts** for health checks, service readiness waiting, and log collection.
- Used **Docker/Docker Compose** to create a reproducible test environment and performed **API integration testing** using curl/Postman/Newman.
- Practiced debugging pipeline failures, environment issues, and build/test integration in a Linux-based workflow.
