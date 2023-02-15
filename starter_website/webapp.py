from flask import Flask, render_template, url_for
from flask import request, redirect
from db_connector.db_connector import connect_to_database, execute_query
#create the web application
webapp = Flask(__name__)


# source venv/scripts/activate.bat // in CMD
# source venv/scripts/activate.ps1 // in powershell
# export FLASK_APP=run.py
# python -m flask run -h 0.0.0.0 -p 1909 --reload

# gunicorn run:webapp -b 0.0.0.0:1909 -D


# home page with links to other pages
@webapp.route('/')
def index():
    # return "Hello, there"

    return render_template('index.html')


@webapp.route('/restaurants.html', methods = ['POST', 'GET'])
def restaurants():
    print("Fetching and rendering restaurants web page")
    db_connection = connect_to_database()
    
    if request.method == 'GET':   # display table
        query = 'SELECT * FROM restaurants'
        result = execute_query(db_connection, query).fetchall()
        return render_template('restaurants.html', rows = result)

    if request.method == 'POST' and 'addButton' in request.form:   # add new restaurant
        new_restName = request.form['restName']
        new_city = request.form['city']
        new_state = request.form['state']
        data = (new_restName, new_city, new_state)
        print(data)
        query = 'INSERT into restaurants (restName, city, state) VALUES (%s, %s, %s)'
        execute_query(db_connection, query, data)
        return redirect(url_for('restaurants'))

    if request.method == 'POST' and 'deleteButton' in request.form:
        restId = request.form['restId']
        data = (restId,)
        query = 'DELETE from restaurants WHERE restId = %s'
        result = execute_query(db_connection, query, data)
        return redirect(url_for('restaurants'))


"""
# classes page that allows adding and deleting classes
@webapp.route('/restaurants.html', methods = ['POST', 'GET', 'DELETE'])
def restaurants():
    print("Fetching and rendering restaurants web page")
    db_connection = connect_to_database()
    if request.method == 'GET':   # display table
        query = 'SELECT * FROM restaurants'
        result = execute_query(db_connection, query).fetchall()

        # teacher_query = 'SELECT * FROM teachers'
        # teacher_result = execute_query(db_connection, teacher_query).fetchall()

        # class_query = 'SELECT * FROM classes'
        # class_result = execute_query(db_connection, class_query).fetchall()

        return render_template('restaurants.html', rows=result, teachers=teacher_result, classes=class_result)

    if request.method == 'POST' and 'addButton' in request.form:   # add class
        teacherId = request.form['teacherId']
        print(teacherId)
        name = request.form['name']
        if request.form['teacherId'] == 'NULL':
            query = 'INSERT into classes (name) VALUES (%s)'
            data = (name,)
        else:
            query = 'INSERT into classes (teacherId, name) VALUES (%s, %s)'
            data = (teacherId, name)
        execute_query(db_connection, query, data)
        return redirect(url_for('classes'))

    if request.method == 'POST' and 'deleteButton' in request.form:   # delete class
        classId = request.form['classId']
        data = (classId,)
        query = 'DELETE from classes WHERE classId = %s'
        result = execute_query(db_connection, query, data)
        return redirect(url_for('classes'))


# classes page that allows adding and searching for teachers
@webapp.route('/teachers.html', methods = ['POST', 'GET'])
def teachers():
    print("Fetching and rendering teachers web page")
    db_connection = connect_to_database()
    if request.method == 'GET':   # display table

        if request.values.get('searchButton') != None:   # check if search was initiated
            last_name = request.values.get('lastName')
            if last_name == "":   # empty filter, whole table will be shown
                query = 'SELECT * FROM teachers'
                result = execute_query(db_connection, query).fetchall()
                return render_template('teachers.html', rows = result)

            else:   # filter by results
                query = 'SELECT * FROM teachers WHERE lastName = %s'
                data = (last_name,)
                result = execute_query(db_connection, query, data).fetchall()
                return render_template('teachers.html', rows = result)

        else:   # no filter enabled, load whole table
            query = 'SELECT * FROM teachers'
            result = execute_query(db_connection, query).fetchall()
            return render_template('teachers.html', rows = result)

    if request.method == 'POST':
        new_first = request.form['firstName']
        new_last = request.form['lastName']
        new_email = request.form['email']
        data = (new_first, new_last, new_email)
        print(data)
        query = 'INSERT into teachers (firstName, lastName, email) VALUES (%s, %s, %s)'
        execute_query(db_connection, query, data)
        return redirect(url_for('teachers'))
        
        
@webapp.route('/students.html', methods = ['POST', 'GET'])
def students():
    print("Fetching and rendering teachers web page")
    db_connection = connect_to_database()
    
    if request.method == 'GET':   # display table
        query = 'SELECT * FROM students'
        result = execute_query(db_connection, query).fetchall()
        return render_template('students.html', rows = result)

    if request.method == 'POST':   # add new student
        new_first = request.form['firstName']
        new_last = request.form['lastName']
        new_email = request.form['email']
        data = (new_first, new_last, new_email)
        print(data)
        query = 'INSERT into students (firstName, lastName, email) VALUES (%s, %s, %s)'
        execute_query(db_connection, query, data)
        return redirect(url_for('students'))
        
@webapp.route('/reviews.html', methods = ['POST', 'GET'])
def reviews():
    print("Fetching and rendering teachers web page")
    db_connection = connect_to_database()

    if request.method == 'GET':   # display table
        query = 'SELECT * FROM reviews'
        result = execute_query(db_connection, query).fetchall()

        review_query = 'SELECT * FROM reviews'
        review_result = execute_query(db_connection, review_query).fetchall()

        teacher_query = 'SELECT * FROM teachers'
        teacher_result = execute_query(db_connection, teacher_query).fetchall()

        student_query = 'SELECT * FROM students'
        student_result = execute_query(db_connection, student_query).fetchall()

        return render_template('reviews.html', rows=result, reviews=review_result, students=student_result, teachers=teacher_result)

    if request.method == 'POST' and 'addButton' in request.form:   # add new review
        year = request.form['year']
        term = request.form['term']
        student = request.form['studentId']
        teacher = request.form['teacherId']
        data = (year, term, student, teacher)
        print(data)
        query = 'INSERT into reviews (reviewYear, reviewTerm, studentId, teacherId) VALUES (%s, %s, %s, %s)'
        execute_query(db_connection, query, data)
        return redirect(url_for('reviews'))

    if request.method == 'POST' and 'updateButton' in request.form:   # update a review
        review = request.form['reviewId']
        year = request.form['year']
        term = request.form['term']
        student = request.form['studentId']
        teacher = request.form['teacherId']
        data = (year, term, student, teacher, review)
        print(data)
        query = 'UPDATE reviews SET reviewYear = %s, reviewTerm = %s, studentId = %s, teacherId = %s WHERE reviewId = %s'
        execute_query(db_connection, query, data)
        return redirect(url_for('reviews'))

@webapp.route('/classesStudentsDetails.html', methods = ['POST', 'GET'])
def classesStudentsDetails():
    print("Fetching and rendering teachers web page")
    db_connection = connect_to_database()

    if request.method == 'GET':   # display table
        query = 'SELECT * FROM classesStudentsDetails'
        result = execute_query(db_connection, query).fetchall()

        class_query = 'SELECT * FROM classes'
        class_result = execute_query(db_connection, class_query).fetchall()

        student_query = 'SELECT * FROM students'
        student_result = execute_query(db_connection, student_query).fetchall()
        return render_template('classesStudentsDetails.html', rows=result, classes=class_result, students=student_result)

    if request.method == 'POST':   # add new class/student relationship
        new_class = request.form['classId']
        new_student = request.form['studentId']
        data = (new_class, new_student)
        print(data)
        query = 'INSERT into classesStudentsDetails (classId, studentId) VALUES (%s, %s)'
        execute_query(db_connection, query, data)
        return redirect(url_for('classesStudentsDetails'))

    """