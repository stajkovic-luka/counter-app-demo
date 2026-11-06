import server
from fastapi.testclient import TestClient

client = TestClient(server.app)


def test_root_returns_200():
    response = client.get("/")
    assert response.status_code == 200
    assert "message" in response.json()

