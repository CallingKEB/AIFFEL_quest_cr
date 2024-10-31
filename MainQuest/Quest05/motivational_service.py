from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from fastapi.responses import JSONResponse
import random

app = FastAPI()

# CORS 설정 추가
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # 모든 출처 허용
    allow_credentials=True,
    allow_methods=["*"],  # 모든 HTTP 메서드 허용 (GET, POST 등)
    allow_headers=["*"],  # 모든 헤더 허용
)

# 출석률 데이터 클래스
class AttendanceData(BaseModel):
    attendance_rate: float

# 목표 설정 데이터 클래스
class GoalResponse(BaseModel):
    current_attendance_rate: float
    next_goal_attendance_rate: float

@app.get("/")
def read_root():
    return "Hello 아이펠!"

@app.get("/recommend_habits")
async def recommend_habits():
    sample_habits = [
        "매일 물 2L 마시기",
        "저녁마다 산책하기",
        "아침 스트레칭",
        "하루 한 장 독서",
        "스스로 운동하기",
        "일기 쓰기",
        "감사 노트 작성"
    ]
    recommended_habits = random.sample(sample_habits, 3)  # 추천 습관 3개 반환
    return JSONResponse(content={"recommended_habits": recommended_habits}, media_type="application/json; charset=utf-8")

# 동기 부여 메시지 생성
@app.post("/motivation")
async def generate_motivation(data: AttendanceData):
    if data.attendance_rate < 0.5:
        messages = ["꾸준히 출석해보세요!", "목표를 달성하기 위해 조금만 더 노력해요!"]
    elif data.attendance_rate < 0.8:
        messages = ["잘하고 있어요! 출석을 이어가세요!", "꾸준함이 중요합니다. 응원합니다!"]
    else:
        messages = ["훌륭해요! 계속해서 열심히 참여해요!", "멋진 출석률이에요! 계속 화이팅!"]

    # UTF-8 인코딩을 명시적으로 설정한 JSON 응답 반환
    return JSONResponse(content={"message": random.choice(messages)}, media_type="application/json; charset=utf-8")

# 출석률 기반 개인 맞춤형 목표 설정
@app.post("/goal", response_model=GoalResponse)
async def set_personalized_goal(data: AttendanceData):
    attendance_rate = data.attendance_rate

    # 다음 목표 설정 (예: 출석률을 10%씩 높이기)
    target_rate = min(1.0, attendance_rate + 0.1)
    
    response_data = {
        "current_attendance_rate": round(attendance_rate, 2),
        "next_goal_attendance_rate": round(target_rate, 2)
    }
    return JSONResponse(content=response_data, media_type="application/json; charset=utf-8")
