import os
import logging
from flask import Flask, session, redirect, url_for, request, render_template, abort
from werkzeug.security import check_password_hash
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager, login_user, logout_user, current_user
from flask_login import UserMixin

basedir = os.path.abspath(os.path.dirname(__file__))

app = Flask(__name__)
app.secret_key = b"192b9bdd22ab9ed4d12e236c78afcb9a393ec15f71bbf5dc987d54727823bcbf"
app.logger.setLevel(logging.INFO)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + os.path.join(basedir, 'database.db')

db = SQLAlchemy(app)
login_manager = LoginManager(app)


class User(UserMixin, db.Model):
    __tablename__ = 'users'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    username = db.Column(db.String(100), unique=True, nullable=False)
    password = db.Column(db.String(100), nullable=False)


@login_manager.user_loader
def load_user(id):
    return db.session.get(User, int(id))


def authenticate(username, password):

    # Get the user from the database if there is any
    user = User.query.filter_by(username=username).first()

    # Check if there is a user and if the password is the same
    if user and check_password_hash(user.password, password):
        app.logger.info(f"the user '{username}' logged in successfully")
        login_user(user)
        return True

    # User is not able to login, return a 401
    app.logger.warning(f"the user '{ username }' failed to log in")
    abort(401)


@app.route("/")
def index():
    return render_template("index.html", is_authenticated=current_user.is_authenticated)


@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        username = request.form.get("username")
        password = request.form.get("password")
        if authenticate(username, password):
            return redirect(url_for("index"))
    return render_template("login.html")


@app.route("/logout")
def logout():
    logout_user()
    return redirect(url_for("index"))


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
