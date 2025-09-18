# Training Robot for Teaching Students (ERT)

Spring Boot 3 (Java 17) REST API to manage Robots, Students, Courses, Training Sessions (scheduling), and Enrollment.

## What you get

- CRUD APIs for Robot, Student, Course
- **TrainingSession scheduling** with overlap validation per robot
- **Enrollment** API (enroll & drop) with capacity checks
- DTOs, Services, Validators, Repositories, Exception Handling
- H2 (in-memory, default) + MySQL profile & schema file
- Seed data via `data.sql`

## Run (H2 default)

```bash
mvn spring-boot:run
# H2 Console: http://localhost:8080/h2-console
# JDBC URL: jdbc:h2:mem:ertdb
```

## Switch to MySQL

1. Create DB & tables:
   ```sql
   SOURCE db/mysql_schema.sql;
   ```
2. Edit `src/main/resources/application-mysql.properties` with your username/password.
3. Run with MySQL profile:
   ```bash
   mvn spring-boot:run -Dspring-boot.run.profiles=mysql
   ```

## REST Endpoints (samples)

### Robots
```
POST   /api/v1/robots
GET    /api/v1/robots
GET    /api/v1/robots/{id}
PUT    /api/v1/robots/{id}
DELETE /api/v1/robots/{id}
```

### Students
```
POST   /api/v1/students
GET    /api/v1/students
GET    /api/v1/students/{id}
PUT    /api/v1/students/{id}
DELETE /api/v1/students/{id}
```

### Courses
```
POST   /api/v1/courses
GET    /api/v1/courses
GET    /api/v1/courses/{id}
PUT    /api/v1/courses/{id}
DELETE /api/v1/courses/{id}
```

### Training Sessions
```
POST   /api/v1/sessions
PUT    /api/v1/sessions/{id}
GET    /api/v1/sessions
GET    /api/v1/sessions/{id}
GET    /api/v1/sessions/by-course/{courseId}
GET    /api/v1/sessions/by-robot/{robotId}
DELETE /api/v1/sessions/{id}
```

**Body (POST/PUT):**
```json
{
  "courseId": 1,
  "robotId": 1,
  "startTime": "2025-08-20T10:00:00",
  "endTime": "2025-08-20T12:00:00",
  "location": "Lab A"
}
```

### Enrollment
```
POST   /api/v1/enrollments?studentId=1&courseId=1
DELETE /api/v1/enrollments?studentId=1&courseId=1
GET    /api/v1/enrollments/by-student/{studentId}
GET    /api/v1/enrollments/by-course/{courseId}
```

## Notes
- Overlap check prevents a robot from being double-booked (`start < existing.end && end > existing.start`).
- Capacity check prevents enrollment if course is full.
- GlobalExceptionHandler returns clean error bodies.
```

