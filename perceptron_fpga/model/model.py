import numpy as np
import sklearn
import sklearn.neural_network
from sklearn.metrics import mean_absolute_error
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import OneHotEncoder
from sklearn import datasets


digits = datasets.load_digits()
n_samples = len(digits.images)
data = digits.images.reshape((n_samples, -1))

clf = sklearn.neural_network.MLPRegressor(alpha=0, verbose=True, activation='identity', hidden_layer_sizes=(128,128))
target = OneHotEncoder(sparse=False).fit_transform(
    digits.target.reshape(-1, 1)
)  # para que haga regresion contra

X_train, X_test, y_train, y_test = train_test_split(
    data, target, test_size=0.8, shuffle=False
)

clf.fit(X_train, y_train)

predicted = clf.predict(X_test)

print("error absoluto promedio: " + str(mean_absolute_error(y_test, predicted)))


# Tiro las primeras 10 imagenes a txt
for i in range(0, 10):
    prediction = clf.predict(data[i:i+1])
    print(f"target: {digits.target[i]}, prediction ({np.argmax(prediction)}): {prediction}")
    image = data[i]
    with open(f'image_{i}.txt', 'w') as file:
        file.write('\n'.join(str(pixel) for pixel in image))

biases = []
for bias_layer in clf.intercepts_:
    biases += bias_layer.tolist()

biases_output = 'biases.txt'
with open(biases_output, 'w') as file:
    file.write('\n'.join(str(bias) for bias in biases))

print("Biases escritos en " + biases_output)

weights = []
for layer_weights in clf.coefs_:
    transposed_matrix = layer_weights.T
    for node_weights in transposed_matrix:
        for weight in node_weights:
            weights.append(weight)

weights_output = "weights.txt"
with open(weights_output, "w") as f:
    f.write('\n'.join(str(x) for x in weights))
print("Coeficientes escritos en " + weights_output)






















