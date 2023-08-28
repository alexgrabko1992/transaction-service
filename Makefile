export PATH := /home/pandanus/go/bin:$(PATH)

postgres:
	docker run --name postgres15 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:15-alpine

createdb:
	docker exec -it postgres15 createdb --username=root --owner=root transactions

dropdb:
	docker exec -it postgres15 dropdb transactions

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/transactions?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/transactions?sslmode=disable" -verbose down

sqlc:
	sqlc generate

.PHONY: createdb dropdb postgres migrateup migratedown sqlc