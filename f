const fs = require('fs');
const ytdl = require('ytdl-core');

async function downloadVideo(url, savePath, formatChoice) {
    try {
        // Determine file extension based on format choice
        let fileExtension = formatChoice === '1' ? 'mp4' : formatChoice === '2' ? 'mp3' : '';
        if (!fileExtension) {
            console.log("Invalid format choice. Please choose '1' for 'MP4' or '2' for 'MP3'.");
            return;
        }

        // Check if save path exists, create directory if not
        if (!fs.existsSync(savePath)) {
            fs.mkdirSync(savePath, { recursive: true });
        }

        // Set quality options based on format choice
        let qualityOptions = formatChoice === '1' ? { quality: 'highestvideo' } : { filter: 'audioonly' };

        // Download the video or audio
        let stream = ytdl(url, qualityOptions);
        stream.pipe(fs.createWriteStream(`${savePath}/video.${fileExtension}`));
        console.log("Download successful.");
    } catch (error) {
        console.error("An error occurred:", error);
    }
}

// Prompt for format choice
console.log("Choose the format:");
console.log("1. MP4");
console.log("2. MP3");

const readline = require('readline').createInterface({
    input: process.stdin,
    output: process.stdout
});

readline.question("Enter your choice (1 or 2): ", (formatChoice) => {
    // Prompt for URL
    readline.question("Paste the URL of the YouTube video: ", (videoUrl) => {
        // Specify the path to save the downloaded video
        const saveLocation = "./Videos";

        // Download the video or audio
        downloadVideo(videoUrl, saveLocation, formatChoice);

        // Close the readline interface
        readline.close();
    });
});
