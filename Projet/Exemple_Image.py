from tensorflow.keras.datasets import mnist

import matplotlib.pyplot as plt

(x_train, y_train), (x_test, y_test) = mnist.load_data()

# Afficher la première image du jeu de données d'entraînement
plt.imshow(x_train[0], cmap='gray')
plt.show()