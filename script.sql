create table categories
(
    id   int auto_increment
        primary key,
    name varchar(50) null,
    constraint name
        unique (name)
)
    collate = utf8mb4_general_ci;

create table coupons
(
    id     int auto_increment
        primary key,
    code   varchar(50)          not null,
    active tinyint(1) default 1 not null
);

create table coupon_conditions
(
    id              int auto_increment
        primary key,
    coupon_id       int           not null,
    attribute       varchar(255)  not null,
    operator        varchar(10)   not null,
    value           varchar(255)  not null,
    discount_amount decimal(5, 2) not null,
    constraint coupon_conditions_ibfk_1
        foreign key (coupon_id) references coupons (id)
);

create index coupon_id
    on coupon_conditions (coupon_id);

create table flyway_schema_history
(
    installed_rank int                                 not null
        primary key,
    version        varchar(50)                         null,
    description    varchar(200)                        not null,
    type           varchar(20)                         not null,
    script         varchar(1000)                       not null,
    checksum       int                                 null,
    installed_by   varchar(100)                        not null,
    installed_on   timestamp default CURRENT_TIMESTAMP not null,
    execution_time int                                 not null,
    success        tinyint(1)                          not null
);

create index flyway_schema_history_s_idx
    on flyway_schema_history (success);

create table lessons
(
    id          int auto_increment
        primary key,
    name        varchar(350)   null comment 'Tên bài học',
    price       decimal(10, 2) null,
    thumbnail   varchar(255)   null,
    description longtext       null,
    created_at  datetime       null,
    updated_at  datetime       null,
    category_id int            null,
    constraint lessons_ibfk_1
        foreign key (category_id) references categories (id)
);

create table lesson_game
(
    id        int auto_increment
        primary key,
    lesson_id int         null,
    game_type varchar(50) null comment 'Loại trò chơi',
    game_data longtext    null comment 'Dữ liệu trò chơi',
    constraint lesson_game_ibfk_1
        foreign key (lesson_id) references lessons (id)
            on delete cascade
)
    collate = utf8mb4_general_ci;

create index lesson_id
    on lesson_game (lesson_id);

create table lesson_media
(
    id        int auto_increment
        primary key,
    lesson_id int          null,
    image_url varchar(300) null,
    constraint lesson_media_ibfk_1
        foreign key (lesson_id) references lessons (id),
    constraint fk_product_images_product_id
        foreign key (lesson_id) references lessons (id)
            on delete cascade
)
    collate = utf8mb4_general_ci;

create table lesson_video
(
    id        int auto_increment
        primary key,
    lesson_id int          null,
    video_url varchar(300) null,
    constraint lesson_video_ibfk_1
        foreign key (lesson_id) references lessons (id)
            on delete cascade
)
    collate = utf8mb4_general_ci;

create index lesson_videos_ibfk_1
    on lesson_video (lesson_id);

create index category_id
    on lessons (category_id);

create table roles
(
    id   int         not null
        primary key,
    name varchar(20) not null
)
    collate = utf8mb4_general_ci;

create table users
(
    id                  int auto_increment
        primary key,
    fullname            varchar(100) default '' null,
    phone_number        varchar(15)             null,
    address             varchar(200) default '' null,
    password            char(60)                not null,
    created_at          datetime                null,
    updated_at          datetime                null,
    is_active           tinyint(1)   default 1  null,
    date_of_birth       date                    null,
    facebook_account_id int          default 0  null,
    google_account_id   int          default 0  null,
    role_id             int          default 1  null,
    email               varchar(255) default '' null,
    profile_image       varchar(255) default '' null,
    constraint users_ibfk_1
        foreign key (role_id) references roles (id)
)
    collate = utf8mb4_general_ci;

create table comments
(
    id         int auto_increment
        primary key,
    product_id int          null,
    user_id    int          null,
    content    varchar(255) null,
    created_at datetime     null,
    updated_at datetime     null,
    constraint comments_ibfk_1
        foreign key (product_id) references lessons (id),
    constraint comments_ibfk_2
        foreign key (user_id) references users (id)
);

create index product_id
    on comments (product_id);

create index user_id
    on comments (user_id);

create table favorites
(
    id         int auto_increment
        primary key,
    user_id    int null,
    product_id int null,
    constraint favorites_ibfk_1
        foreign key (user_id) references users (id),
    constraint favorites_ibfk_2
        foreign key (product_id) references lessons (id)
);

create index product_id
    on favorites (product_id);

create index user_id
    on favorites (user_id);

create table parent_accounts
(
    id          int auto_increment
        primary key,
    provider    varchar(20)  not null comment 'Tên nhà social network',
    provider_id varchar(50)  not null,
    email       varchar(150) not null comment 'Email tài khoản',
    name        varchar(100) not null comment 'Tên người dùng',
    student_id  int          null,
    constraint parent_accounts_ibfk_1
        foreign key (student_id) references users (id)
)
    collate = utf8mb4_general_ci;

create index user_id
    on parent_accounts (student_id);

create table progress
(
    id              int auto_increment
        primary key,
    user_id         int                                                                                                 null,
    lesson_name     varchar(100)                            default ''                                                  null,
    email           varchar(100) collate utf8mb4_general_ci default ''                                                  null,
    phone_number    varchar(20) collate utf8mb4_general_ci                                                              not null,
    address         varchar(200) collate utf8mb4_general_ci                                                             not null,
    email_reminder  varchar(255)                                                                                        null,
    date_started    datetime                                                                                            null,
    status          enum ('not_started', 'in_progress', 'completed', 'pending', 'cancelled') collate utf8mb4_general_ci null comment 'Trạng thái tiến trình học tập',
    progress        float                                                                                               null comment 'Progress in percentage',
    study_method    varchar(100) collate utf8mb4_general_ci                                                             null,
    study_address   varchar(200) collate utf8mb4_general_ci                                                             null,
    reminder_date   datetime                                                                                            null,
    tracking_number varchar(100) collate utf8mb4_general_ci                                                             null,
    learning_method varchar(100) collate utf8mb4_general_ci                                                             null,
    active          tinyint(1)                                                                                          null,
    reward_id       int                                                                                                 null,
    constraint fk_orders_coupon
        foreign key (reward_id) references coupons (id),
    constraint progress_ibfk_1
        foreign key (user_id) references users (id)
);

create index user_id
    on progress (user_id);

create table progress_details
(
    id          int auto_increment
        primary key,
    progress_id int                         null,
    lesson_id   int                         null,
    max_score   decimal(10, 2)              null,
    progress    int            default 1    null,
    total_score decimal(10, 2) default 0.00 null,
    break_start varchar(20)                 null,
    reward_id   int                         null,
    constraint fk_order_details_coupon
        foreign key (reward_id) references coupons (id),
    constraint progress_details_ibfk_1
        foreign key (progress_id) references progress (id),
    constraint progress_details_ibfk_2
        foreign key (lesson_id) references lessons (id)
);

create index order_id
    on progress_details (progress_id);

create index product_id
    on progress_details (lesson_id);

create table tokens
(
    id                      int auto_increment
        primary key,
    token                   varchar(255)            not null,
    token_type              varchar(50)             not null,
    expiration_date         datetime                null,
    revoked                 tinyint(1)              not null,
    expired                 tinyint(1)              not null,
    user_id                 int                     null,
    is_mobile               tinyint(1)   default 0  null,
    refresh_token           varchar(255) default '' null,
    refresh_expiration_date datetime                null,
    constraint token
        unique (token),
    constraint tokens_ibfk_1
        foreign key (user_id) references users (id)
)
    collate = utf8mb4_general_ci;

create index user_id
    on tokens (user_id);

create index role_id
    on users (role_id);


