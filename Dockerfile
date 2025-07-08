# Build stage
FROM dart:stable AS build
WORKDIR /app
COPY . .

# Install dependencies and compile the server executable
RUN dart pub get
RUN dart compile exe kunhavigi_server/bin/main.dart -o kunhavigi_server/bin/server

# Final stage
FROM alpine:latest

# Environment variables
ENV runmode=staging
# ENV runmode=production
ENV serverid=default
ENV logging=normal
ENV role=monolith

# Copy runtime dependencies
COPY --from=build /runtime/ /

# Copy compiled server executable
COPY --from=build /app/kunhavigi_server/bin/server server

# Copy configuration files and resources
COPY --from=build /app/kunhavigi_server/config/ config/
COPY --from=build /app/kunhavigi_server/web/ web/
COPY --from=build /app/kunhavigi_server/migrations/ migrations/

# This file is required to enable the endpoint log filter in Insights.
COPY --from=build /app/kunhavigi_server/lib/src/generated/protocol.yaml lib/src/generated/protocol.yaml

# Expose ports
EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

# Define the entrypoint command
ENTRYPOINT ["./server", "--mode=${runmode}", "--server-id=${serverid}", "--logging=${logging}", "--role=${role}", "--apply-migrations"]
