import setuptools

with open("README.md", "r") as fh:
    long_description = fh.read()

setuptools.setup(
    name="subjective_test",
    version="0.0.1",
    author="Babak Naderi",
    author_email="bnaderi9@gmail.com",
    description="Transforming the Mean Opinion Scores (MOS) values given their 95% Confidence Intervals to safely use "
                "rank based statictial techniques.",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/babaknaderi/MOS-transformation",
    packages=setuptools.find_packages(),
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires='>=3.6',
)