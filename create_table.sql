use sofascore_ssis;

create table session_dim
(
    session_id   INT PRIMARY KEY,
    session_name VARCHAR(100),
    session_year VARCHAR(50)

);

create table status_dim
(
    status_id          INT PRIMARY KEY IDENTITY (1,1),
    status_code        INT,
    status_description VARCHAR(50),
    status_type        VARCHAR(50)
);

create table score_dim
(
    score_id    SMALLINT PRIMARY KEY IDENTITY (1,1),
    score       SMALLINT,
    period_1    SMALLINT,
    period_2    SMALLINT,
    normal_time SMALLINT,
    extra_1     SMALLINT,
    extra_2     SMALLINT,
    overtime    SMALLINT,
);

create table round_dim
(
    round_id   INT IDENTITY (1,1) PRIMARY KEY,
    round      INT,
    round_name VARCHAR(50)
);

create table add_time_dim
(
    add_time_id SMALLINT IDENTITY PRIMARY KEY,
    add_time_1  SMALLINT,
--     (DT_I2)(time2 == "finished" ? "-2" : time2 == "postponed" ? "-3" : time2 == "Ended" ? "-4" : time2 == "AP" ? "-5" : time2 == "canceled" ? "-6" : time2 == "notstarted" ? "-7" : time2)
    add_time_2  SMALLINT,
    add_time_3  SMALLINT,
    add_time_4  SMALLINT,
);

create table team_dim
(
    team_id         INT PRIMARY KEY IDENTITY (1,1),
    name            VARCHAR(50),
    short_name      VARCHAR(50),
    country         VARCHAR(50),
    color_primary   VARCHAR(50),
    color_secondary VARCHAR(50)
);

create table category_dim
(
    category_id     SMALLINT PRIMARY KEY,
    category_name   VARCHAR(30),
    category_flag   VARCHAR(30),
    category_alpha2 VARCHAR(2)
);

create table match_fact
(
    match_id        INT,
    category_id     SMALLINT FOREIGN KEY REFERENCES category_dim (category_id),
    session_id      INT FOREIGN KEY REFERENCES session_dim (session_id),
    round_id        INT FOREIGN KEY REFERENCES round_dim (round_id),
    home_team_id    INT FOREIGN KEY REFERENCES team_dim (team_id),
    away_team_id    INT FOREIGN KEY REFERENCES team_dim (team_id),
    home_score_id   SMALLINT FOREIGN KEY REFERENCES score_dim (score_id),
    away_score_id   SMALLINT FOREIGN KEY REFERENCES score_dim (score_id),
    add_time_id     SMALLINT FOREIGN KEY REFERENCES add_time_dim (add_time_id),
    status_id       INT FOREIGN KEY REFERENCES status_dim (status_id),
    start_timestamp VARCHAR(50)
);
