#include <Arduino.h>
#include <Arduino_OV767X.h>
#include <TensorFlowLite.h>

#include "C:\Users\binet\Desktop\IA\rednu project\detect_img\qat_model.h5" //modéle pré-entrainé
#include "tensorflow/lite/micro/micro_error_reporter.h"
#include "tensorflow/lite/micro/micro_interpreter.h"
#include "tensorflow/lite/schema/schema_generated.h"
#include "tensorflow/lite/version.h"

// constantes pour la cam
const int kNumCols = 176;
const int kNumRows = 144;
unsigned short pixels[kNumCols * kNumRows];

// constantes pour le modèle
const int kNumClasses = 10;
const int kTensorArenaSize = 4 * 1024;
uint8_t tensor_arena[kTensorArenaSize];

// variables pour l'inférence
float input_data[kNumCols * kNumRows];
float output_scores[kNumClasses];

void setup() {
  Serial.begin(9600);
  while (!Serial);

  // initialisation de la caméra
  if (!Camera.begin(QCIF, RGB565, 1)) {
    Serial.println("Erreur d'initialisation de la caméra !");
    while (1);
  }

  // initialisation du modèle
  const tflite::Model* model = tflite::GetModel(qat_model);
  tflite::MicroInterpreter interpreter(
      model, tflite::AllOpsResolver(), tensor_arena, kTensorArenaSize,
      &micro_error_reporter);
  interpreter.AllocateTensors();

  // config de TinyMLx
  TinyMLx.begin(&interpreter);
  TinyMLx.setOutputActivationParameters(0, 0.0, 1.0);

  Serial.println("Envoyez le caractère 'c' pour lire une image ...");
}


void loop() {
  if (Serial.read() == 'c') {
    Camera.readFrame(pixels);

    // on redim l'image pour fit le model
    ImageResize.resize(pixels, kNumCols, kNumRows, resized_image, kNewCols, kNewRows, IMAGE_NEARESTNEIGHBOR);
    // On normalise la valeurs des pixels
    normalize_image(resized_image, input_tensor->data.f, kNumCols * kNumRows);

    // Exécution de l'inférence
    interpreter.Invoke();

    //on veut prendre le tensor en sortie et sa longueur
    TfLiteTensor* output_tensor = interpreter->output(0);
    const int output_length = output_tensor->bytes / sizeof(float); 
    //ces deux lignes on été trouvé sur internet (à vérifier si possible dans le futur)

    // on cherche l'index avec la valeurs de confidence la plus grande
    int best_index = 0;
    float best_confidence = 0.0;
    for (int i = 0; i < output_length; i++) {
      float confidence = output_tensor->data.f[i];
      if (confidence > best_confidence) {
        best_index = i;
        best_confidence = confidence;
      }
    }

    // affichage des predictions
    Serial.print("Prediction: ");
    Serial.print(best_index);
    Serial.print(" (");
    Serial.print(best_confidence, 4);
    Serial.println(")");
  }
}

