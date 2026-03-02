const request = require("supertest");
const app = require("../../src/app");

describe("API tests", () => {
    test("GET /health should return 200", async () => {
        const res = await request(app).get("/health");
        expect(res.statusCode).toBe(200);
        expect(res.body.status).toBe("ok");
    });

    test("GET /api/version should return version", async () => {
        const res = await request(app).get("/api/version");
        expect(res.statusCode).toBe(200);
        expect(res.body).toHaveProperty("version");
    });

    test("POST /api/echo should return posted body", async () => {
        const payload = { message: "hello" };
        const res = await request(app).post("/api/echo").send(payload);
        expect(res.statusCode).toBe(200);
        expect(res.body.received).toEqual(payload);
    });
});
