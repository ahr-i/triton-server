echo "Install stable_diffusion"
echo "Output folder setting."
cd models
mkdir ahri
cd ahri
echo "Making folder success!"

echo "Model download."
git lfs install
git clone https://huggingface.co/kamalkraj/stable-diffusion-v1-4-onnx
if [ $? -ne 0 ]; then
	echo "*** (ERROR) Model download error."
	exit 1
fi
echo "Downloading model success!"