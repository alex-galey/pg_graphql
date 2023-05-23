begin;
    create schema xxx;

    create table xxx.account(
        id int primary key
    );

    insert into xxx.account(id)
    select * from generate_series(1, 5);

    alter schema "public" rename to "old_public";

    alter schema "xxx" rename to "public";

    select jsonb_pretty(
        graphql.resolve($$
        {
          accountCollection(first: 1) {
            edges {
              node {
                id
              }
            }
          }
        }
        $$)
    );

rollback;
