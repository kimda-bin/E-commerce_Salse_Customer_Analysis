# E-commerce_Salse_Customer_Analysis
Python, SQL, Tableau를 활용한 이커머스 데이터 분석 미니 프로젝트

---

## 프로젝트 개요
- **기간:** 2026.02.19~2026.03.07
- **기술스택:** Python(Pandas), SQL
- **활용 툴:** Visual Studio Code, Tableau, Jupyter Notebook
- **데이터:** Kaggle [Amazon Seller - Order Status Prediction]

## 분석 목적&가설
**분석 목적**
- 전체 매출은 얼마인가?
- 월별 매출 추이는 어떻게 변화하는가?
- 재구매 고객 비율은 얼마인가?
- 상위 고객 매출 비중은 얼마나 되는가?
- 결제수단별 매출 구조는 어떠한가?

**가설**
- 매출은 소수 고객에게 집중되어 있을 것이다
- 연말엔 소비 증가로 인해 월 평균 대비 매출이 높을 것이다
- 재구매 고객은 전체 매출에서 높은 비중을 차지할 것이다

---

## 데이터 구조
- raw_orders : 원본 데이터 테이블
- clean_orders : 분석용 데이터 테이블

---

## 분석 과정
1. **데이터베이스 구축**    
    - PostgreSQL에서 원본 데이터용 raw_orders 테이블과 분석용 데이터 적재용 clean_orders 테이블 생성
    - Python으로 원본 데이터를  raw_orders에 적재
    - SQL을 활용하여 분석에 필요한 컬럼을 선별하고 데이터 형식을 정리하여 clean_orders에 데이터 적재
    
2. **SQL을 활용한 기본 데이터 확인**
    - 행 갯수 확인
    - 주문비용 범위 확인
    - 총 주문 비용 확인
    - 주문단위 확인
    - 고객 수
    - 월별 매출
    
    ```sql
    -- 행 갯수 확인
    select count(*) from clean_orders
    
    -- 주문비용 범위 확인
    select min(item_total), max(item_total) from clean_orders
    
    -- 월별 매출
    select date_trunc('month',order_date) as month, sum(item_total) as total_sales
    from clean_orders
    group by month
    order by month
    
    ```
    
3. **탐색적 데이터 분석(EDA)**
- 기술적 EDA
    - 데이터 기본 구조 및 자료형 확인
    - 결측치 확인 후 제거
    - describe()를 통한 기초 통계
    - 중복 데이터 확인
    - 주문날짜 범위 확인
    
    ```python
    # 데이터프레임 크기 확인
    data.shape
    
    # 컬럼별 자료형
    data.info()
    
    # 숫자형 컬럼 체크(기초 통계)
    df.describe()
    
    # 중복 확인
    # 주문번호 기준
    print(df['order_no'].duplicated().sum())
    ```
    
- 비즈니스 탐색 EDA
    - 고객별 매출 분포 / 상위 고객 매출 비중 확인
    - 월별 매출 추이 / 월별 매출 확인
    - 재구매 고객 분포 / 재구매 고객 매출 확인
    - 결제 수단별 매출 비중
    
    ```python
    # 고객별 매출 확인
    customer_sales = df.groupby('buyer')['item_total'].sum()
    reset_index_customer_sales = customer_sales.reset_index()
    
    # 월별 매출 추이
    month_sales = df.groupby('year_month')['item_total'].sum()
    print("월별 매출 추이 :",month_sales)
    
    # 2회 이상 구매한 고객의 비율
    repeat_customer = df.groupby('buyer').size().reset_index(name='purchase_count')
    repeat_customers = repeat_customer[repeat_customer['purchase_count'] >= 2]
    repeat_customer_ratio = (repeat_customers['buyer'].count() / repeat_customer['buyer'].count()) * 100
    print("2회 이상 구매한 고객의 비율 :",repeat_customer_ratio)
    
    # 결제수단별 매출 비중
    # Credit Card는 인터넷 결제를 의미하고 Cash On Delivery는 물품 수령 후 결제를 의미한다.
    cod_sales = df.groupby('cod')['item_total'].sum()
    print(cod_sales)
    ```
    
4. **데이터 분석**
    - 고객별 매출 분석
    - 월별 매출 분석
    - 재구매 고객 분석
    
5. **데이터 시각화**
    - 월별 매출 추이
    - 상위 고객 매출 분포
    - 재구매 고객 매출 비중

---

## 시각화/인사이트
**[시각화]**
- 월별 매출 추이 (라인 차트)
- 상위 고객 매출 분포 (파레토 차트)
- 재구매 고객 매출 비중 (파이 차트)
- Tableau 대시보드 링크 : https://public.tableau.com/app/profile/.22523362/viz/_17728930899900/sheet3?publish=yes

**[인사이트]**
- 상위 10% 고객은 전체 매출의 약 30%를 차지 --> 비교적 매출이 분산되어 있는 구조
- 연말 매출이 기타 월 평균 대비 320% 높은 수준 --> 연말 수요 집중 패턴을 보임
- 재구매 고객 매출의 비율은 전체 매출의 약 28% --> 재구매 고객을 타깃으로 한 전략 필요

---

## 분석한계
- 데이터가 2021년 6월 ~ 2022년 2월인 9개월의 짧은 기간으로, 추가적인 데이터 수집이 필요하다.
- 해당 데이터는 예시 데이터로, 실제 비즈니스 상황과 차이가 있을 수 있다.
