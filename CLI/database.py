import pymysql
import os
import re
from queries import DROP_TABLES, CREATE_TABLES, INSERT_DATA, QUERY_DATA

mysql_config = {
    'HOST': os.environ.get('HOST'),
    'USER': os.environ.get('USER'),
    'PASS': os.environ.get('PASS'),
    'DATABASE': os.environ.get('DATABASE')
}


def get_connection():
    my_conn = None
    try:
        my_conn = pymysql.connect(
            host=mysql_config['HOST'],
            user=mysql_config['USER'],
            password=mysql_config['PASS'],
            database=mysql_config['DATABASE']
        )
        my_conn.mysql_config = mysql_config

    except Exception as err:
        print(f'Could not connect to database: {err}')

    return my_conn


def drop_all_tables(db_conn):
    queries = DROP_TABLES.split(';')
    errors = execute_queries(db_conn, queries)
    return queries, errors


def create_tables(db_conn):
    queries = CREATE_TABLES.split(';')
    errors = execute_queries(db_conn, queries)
    return queries, errors


def query_er(db_conn):
    queries = QUERY_DATA.split(';')[:-1]
    errors, results = execute_queries(db_conn, queries, True)
    return errors, results, queries


def execute_queries(db_conn, queries, fetch=None):
    errors = []
    results = []
    for q in queries:
        error, result = execute_query(db_conn, q, fetch)
        if error:
            errors.append(result)
            continue
        results.append(result)
    return errors, results


def execute_query(db_conn, query='', fetch=False):
    try:
        cursor = db_conn.cursor()
        if fetch:
            cursor.execute(query)
            result = cursor.fetchall()
        else:

            result = cursor.execute(query)
    except Exception as e:
        return True, f'Could not perform {query}\n{e}'
    else:
        cursor.close()

    db_conn.commit()
    return False, result


def fill_er(db_conn):
    queries = INSERT_DATA.split(';')
    errors = execute_queries(db_conn, queries)
    return queries, errors


def fill_temporal(db_conn, values):
    original_query = """
    USE `DATAWAREHOUSE`;
    INSERT INTO `DATAWAREHOUSE`.`temporal`
    (
    `nombre_eleccion`,
    `anio_eleccion`,
    `pais`,
    `region`,
    `Departamento`,
    `Municipio`,
    `Partido`,
    `Nombre_paritdo`,
    `Sexo`,
    `Raza`,
    `Analfabetos`,
    `Alfabetos`,
    `Primaria`,
    `Nivel_Medio`,
    `Universitarios`)
    VALUES
    """
    batch_size = 1000
    batch_count = 0
    sql_values = ()
    count = 0
    i = 0
    query = original_query
    errors = 0
    values_list = list(values)
    max_length = len(values_list)
    for value in values_list:
        i += 1
        if i >= batch_size or count + i >= max_length - 1:
            query = query[:-2] + ';'
            queries = (query % sql_values).split(';')[:-1]
            err, queries = execute_queries(db_conn, queries)
            count += i
            batch_count += 1
            errors += len(err)
            query = original_query
            sql_values = ()
            i = 0

        query += """('%s','%s','%s','%s','%s','%s','%s','%s','%s','%s',%i,%i,%i,%i,%i),\n"""
        sql_values += (value.NOMBRE_ELECCION, value.ANIO_ELECCION, value.PAIS, value.REGION, value.DEPTO, value.MUNICIPIO,
                       value.PARTIDO, value.NOMBRE_PARTIDO, value.SEXO, value.RAZA, value.ANALFABETOS, value.ALFABETOS,
                       value.PRIMARIA, value.NIVEL_MEDIO, value.UNIVERSITARIOS)

    db_conn.commit()
    return f'Inserted {count} registries in {batch_count} batches, error #: {errors}'
