import joblib

# charge un fichier joblib contenant une régression linéaire entraînée
model = joblib.load('modele.joblib')

# Rrécupère les valeurs de coefficients 
coefficients = model.coef_
intercept = model.intercept_

# génère une chaîne de caractère contenant le code C permettant de calculer la prédiction du modèle 
# (float prediction(float *features, int n_feature) )avec les valeur du coefficient
code_c = 'float prediction(float *features, int n_feature) {\n'
code_c += '\tfloat result = %f;\n' % intercept
for i in range(len(coefficients)):
    code_c += '\tresult += %ffeatures[%d];\n' % (coefficients[i], i)
code_c += '\treturn result;\n}\n'

# sauvegarde le code c généré dans un fichier.c 
with open('modele.c', 'w') as f:
    f.write(code_c)

main_code = '#include <stdio.h>\n\n'
main_code += 'float prediction(float *features, int n_feature);\n\n'
main_code += 'int main() {\n'
main_code += '\tfloat features[] = {1.0, 2.0, 3.0};\n'
main_code += '\tfloat result = prediction(features, %d);\n' % len(coefficients)
main_code += '\tprintf("Prediction : %f\\n", result);\n'
main_code += '\treturn 0;\n}\n'

with open('main.c', 'w') as f:
    f.write(main_code)

# ffiche la commande de compilation à lancer pour le compiler ou le compile directement.
print('Pour compiler et exécuter le code généré : gcc modele.c main.c -o modele & start modele.exe')

