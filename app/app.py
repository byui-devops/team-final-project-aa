from flask import Flask, render_template, abort
from recipes import recipes

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html', recipes=recipes)

@app.route('/recipe/<int:recipe_id>')
def recipe(recipe_id):
    recipe = next((r for r in recipes if r["id"] == recipe_id), None)
    if not recipe:
        abort(404)
    return render_template('recipe.html', recipe=recipe)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
