import cv2
import sys
from joblib import dump, load
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

def train():
    clf = sklearn.neural_network.MLPRegressor(alpha=0, verbose=True, activation='identity', hidden_layer_sizes=(128,128))
    target = OneHotEncoder(sparse=False).fit_transform(
        digits.target.reshape(-1, 1)
    )  # para que haga regresion contra

    X_train, X_test, y_train, y_test = train_test_split(
        data, target, test_size=0.8, shuffle=False
    )

    clf.fit(X_train, y_train)
    dump(clf, 'model.joblib')
    predicted = clf.predict(X_test)

    print("error absoluto promedio: " + str(mean_absolute_error(y_test, predicted)))

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


def save_jpg_image(image_index):
    image_array = np.array(data[image_index]*8)
    image_array = image_array.astype(np.uint8)
    image_array = image_array.reshape((8, 8))
    scale_factor = 80
    upscaled_image = cv2.resize(image_array, None, fx=scale_factor, fy=scale_factor, interpolation=cv2.INTER_NEAREST)

    cv2.imwrite(f"image_{image_index}.png", upscaled_image)


def save_txt_images():
    # Tiro las primeras 10 imagenes a txt
    for i in range(0, 10):
        image = data[i]
        with open(f'image_{i}.txt', 'w') as file:
            file.write('\n'.join(str(pixel) for pixel in image))

def test(image_index):
    clf = load('model.joblib')
    print(f"Prediction for image with label {digits.target[image_index]}")
    predictions = clf.predict(data[image_index:image_index+1])[0]
    for index, prediction in enumerate(predictions):
        fix_point_prediction = round(float(prediction) * (2**32))
        res = positive_hex(fix_point_prediction) if fix_point_prediction >= 0 else negative_hex(fix_point_prediction)

        print(f"{index}: {res}")

def negative_hex(input):
    return hex(input & 0xFFFF_FFFF_FFFF_FFFF)[2:].upper()

def positive_hex(input):
    return f"{input:016X}"

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Please pass one command: [train, test, save_txt_images, save_jpg_image]")
        exit(1)

    if sys.argv[1] == 'train':
        train()
    elif sys.argv[1] == 'test':
        if len(sys.argv) < 3:
            print("Please pass an index to test")
            exit(1)
        test(int(sys.argv[2]))
    elif sys.argv[1] == 'save_txt_images':
        save_txt_images()
    elif sys.argv[1] == 'save_jpg_image':
        if len(sys.argv) < 3:
            print("Please pass an index to save")
            exit(1)
        save_jpg_image(int(sys.argv[2]))
