import psycopg2
import collections


def get_real_cols():
    con = connect_to_db()
    cursor = con.cursor()
    cursor.execute("select column_name from information_schema.columns where "
                   "table_schema = 'public' and table_name='observation_fact'")
    return [i[0] for i in cursor.fetchall()]


def connect_to_db():
    conn_string = "host='localhost' dbname='new_db' user='postgres' password=''"
    conn = psycopg2.connect(conn_string)
    return conn


def get_new_columns():
    con = connect_to_db()
    cursor = con.cursor()
    cursor.execute("select distinct concept_cd, valtype_cd from observation_fact")
    cols = cursor.fetchall()
    cursor.close()
    con.close()
    return cols


def column_type(val):
    col_type = 'text'
    if val == 'T':
        col_type = 'TEXT'
    elif val == 'N':
        col_type = 'INTEGER'
    elif val == 'B':
        col_type = 'BOOLEAN'
    return col_type


def create_table(columns_list, tn):
    query = 'CREATE TABLE {0} ('.format(tn)
    query += 'id numeric(18,5), '
    for value in columns_list[:-1]:
        query += "\"" + value[0] + "\"" + ' {0}, '.format(column_type(value[1]))
    else:
        query += "\"" + columns_list[-1][0] + "\"" + ' {0});'.format(column_type(columns_list[-1][1]))

    # create table
    con = connect_to_db()
    cursor = con.cursor()
    cursor.execute('DROP TABLE IF EXISTS {0};'.format(tn))
    cursor.execute(query)
    con.commit()
    cursor.close()
    con.close()


# 'update {0} set "{1}" = {2} where id = {3}'
# table_name concept num_val id
def insert_new_rows(tn, real_columns):
    con = connect_to_db()
    cursor = con.cursor()
    cursor.execute("select * from observation_fact")
    data = cursor.fetchall()
    used_id = set()
    for value in data:
        v = ''
        if value[real_columns.index("valtype_cd")] == 'T':
            v = "'" + str(value[real_columns.index("tval_char")]) + "'"
        elif value[real_columns.index("valtype_cd")] == 'N':
            v = value[real_columns.index("nval_num")]
        try:
            if value[real_columns.index("patient_num")] not in used_id:
                cursor.execute("insert into {0} (id, {1}) VALUES( {2}, {3});"
                               .format(tn, value[real_columns.index("concept_cd")],
                                       value[real_columns.index("patient_num")], v))
            else:
                cursor.execute("update {0} set \"{1}\" = {2} where id = {3};"
                               .format(tn, value[real_columns.index("concept_cd")], v,
                                       value[real_columns.index("patient_num")]))

            used_id.add(value[real_columns.index("patient_num")])
        except Exception as e:
            print value
        con.commit()
    cursor.close()
    con.close()


def write_to_csv(cols, tn, real_columns):
    header = 'id, '
    header_dict = dict()
    index = 1
    for value in cols[:-1]:
        header += value[0] + ', '
        header_dict[value[0]] = index
        index += 1
    else:
        header += cols[-1][0]
        header_dict[cols[-1][0]] = index
    con = connect_to_db()
    cursor = con.cursor()
    cursor.execute("select * from observation_fact")
    data = cursor.fetchall()
    row_dict = collections.defaultdict(dict)
    for value in data:
        row_dict[str(value[real_columns.index("patient_num")])]["id"] = str(value[real_columns.index("patient_num")])
        for item in header.split(', '):
            if value[real_columns.index("concept_cd")] == item and value[real_columns.index("valtype_cd")] == 'T':
                row_dict[str(value[real_columns.index("patient_num")])][item] \
                    = "\"" + str(value[real_columns.index("tval_char")]) + "\""
            elif value[real_columns.index("concept_cd")] == item and value[real_columns.index("valtype_cd")] == 'N':
                row_dict[str(value[real_columns.index("patient_num")])][item] \
                    = str(value[real_columns.index("nval_num")])
    with open(tn + '.csv', 'w') as w:
        w.write(header + '\n')
        for k, v in row_dict.iteritems():
            line = ''
            for item in header.split(', '):
                for key, val in v.iteritems():
                    if key == item and val != "\"None\"" and val != "None":
                        line += str(val) + ','
                    elif key == item and (val == "\"None\"" or val == "None"):
                        line += ','
            w.write(line[:-1] + '\n')


    # with open(tn + '.csv', 'w') as w:
    #     w.write(header + '\n')
    #     for value in data:
    #         w.write(str(value[real_columns.index("patient_num")]))
    #         for item in header.split(', '):
    #             x = ''
    #             if value[real_columns.index("concept_cd")] == item and value[real_columns.index("valtype_cd")] == 'T':
    #                 x += "\"" + str(value[real_columns.index("tval_char")]) + "\""
    #             elif value[real_columns.index("concept_cd")] == item and value[real_columns.index("valtype_cd")] == 'N':
    #                 x += str(value[real_columns.index("nval_num")])
    #             else:
    #                 x += ','
    #             w.write(x)
    #         w.write('\n')
    cursor.close()

    con.close()


if __name__ == "__main__":
    # change this part #
    # set sql for exporting database #
    table_name = 'pivot'
    export_to = 'sql1'
    ####################
    real_cols = get_real_cols()

    columns = get_new_columns()
    if export_to == 'sql':
        create_table(columns, table_name)
        insert_new_rows(table_name, real_cols)
    else:
        write_to_csv(columns, table_name, real_cols)
    print 'Done'

