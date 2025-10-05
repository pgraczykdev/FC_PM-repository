create or replace package fc_pm.tapi_users authid definer as
    subtype t_user_rec is users%rowtype;
    type t_user_rec_aa is
        table of t_user_rec index by pls_integer;
    function f_get_user_by_id (
        pi_id in users.id%type
    ) return t_user_rec;

    function f_get_user_by_username (
        pi_username in users.username%type
    ) return t_user_rec;

    function f_get_user_by_email (
        pi_email in users.email%type
    ) return t_user_rec;

    function f_get_all_users return t_user_rec_aa;

    function f_create_user (
        pi_user_rec in t_user_rec
    ) return users.id%type;

    procedure p_update_user (
        pi_user_rec in t_user_rec
    );

    procedure p_delete_user (
        pi_id in users.id%type
    );

end tapi_users;
/


-- sqlcl_snapshot {"hash":"72eaaf4c0a96fb958e8dbe84d54a3b88a5afd55f","type":"PACKAGE_SPEC","name":"TAPI_USERS","schemaName":"FC_PM","sxml":""}