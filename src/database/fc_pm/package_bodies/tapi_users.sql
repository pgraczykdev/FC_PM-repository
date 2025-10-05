create or replace package body fc_pm.tapi_users as

    gc_global_prefix constant varchar2(30) := $$plsql_unit;
    cursor g_cur_users is
    select
        *
    from
        users;
----------------------------------------------------------------------------
    function f_get_user_by_id (
        pi_id in users.id%type
    ) return t_user_rec is
        l_user_rec t_user_rec;
    begin
        select
            *
        into l_user_rec
        from
            users
        where
            id = pi_id;

        return l_user_rec;
    exception
        when no_data_found then
            return null;
        when others then
            return null;
    end f_get_user_by_id;
----------------------------------------------------------------------------
    function f_get_user_by_username (
        pi_username in users.username%type
    ) return t_user_rec is
        l_user_rec t_user_rec;
    begin
        select
            *
        into l_user_rec
        from
            users
        where
            username = pi_username;

        return l_user_rec;
    exception
        when no_data_found then
            return null;
        when others then
            return null;
    end f_get_user_by_username;
----------------------------------------------------------------------------
    function f_get_user_by_email (
        pi_email in users.email%type
    ) return t_user_rec is
        l_user_rec t_user_rec;
    begin
        select
            *
        into l_user_rec
        from
            users
        where
            email = pi_email;

        return l_user_rec;
    exception
        when no_data_found then
            return null;
        when others then
            return null;
    end f_get_user_by_email;
----------------------------------------------------------------------------
    function f_get_all_users return t_user_rec_aa is
        l_users t_user_rec_aa;
    begin
        for rec in g_cur_users loop
            l_users(rec.id) := rec;
        end loop;
        return l_users;
    end f_get_all_users;
----------------------------------------------------------------------------
    function f_create_user (
        pi_user_rec in t_user_rec
    ) return users.id%type is
        l_new_id users.id%type;
    begin
        insert into users values pi_user_rec returning id into l_new_id;

        return l_new_id;
    exception
        when others then
            return null;
    end f_create_user;
----------------------------------------------------------------------------
    procedure p_update_user (
        pi_user_rec in t_user_rec
    ) is
    begin
        update users
        set
            username = nvl(pi_user_rec.username, username),
            email = nvl(pi_user_rec.email, email),
            password_hash = nvl(pi_user_rec.password_hash, password_hash),
            first_name = nvl(pi_user_rec.first_name, first_name),
            last_name = nvl(pi_user_rec.last_name, last_name),
            updated_at = current_timestamp,
            last_active_at = nvl(pi_user_rec.last_active_at, last_active_at),
            is_active = nvl(pi_user_rec.is_active, is_active)
        where
            id = pi_user_rec.id;

    exception
        when others then
            null;
    end p_update_user;
----------------------------------------------------------------------------
    procedure p_delete_user (
        pi_id in users.id%type
    ) is
    begin
        delete from users
        where
            id = pi_id;

    exception
        when others then
            null;
    end p_delete_user;
----------------------------------------------------------------------------

end tapi_users;
/


-- sqlcl_snapshot {"hash":"6db956dd9966e0a1b55285c214fa038be9c2ef0e","type":"PACKAGE_BODY","name":"TAPI_USERS","schemaName":"FC_PM","sxml":""}