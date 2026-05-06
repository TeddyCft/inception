<?php
$file = "data.txt";

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $input = htmlspecialchars($_POST["message"]);
    file_put_contents($file, $input . PHP_EOL, FILE_APPEND);
}

$messages = file_exists($file) ? file($file, FILE_IGNORE_NEW_LINES) : [];
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Inception Demo</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-900 text-white min-h-screen flex flex-col items-center justify-center">

    <div class="bg-gray-800 p-8 rounded-2xl shadow-lg w-full max-w-xl">
        <h1 class="text-3xl font-bold mb-6 text-center">
            Inception Persistence Demo
        </h1>

        <form method="POST" class="flex gap-2 mb-6">
            <input 
                type="text" 
                name="message" 
                placeholder="Write something..."
                required
                class="flex-1 px-4 py-2 rounded-lg text-black"
            >
            <button class="bg-blue-500 hover:bg-blue-600 px-4 py-2 rounded-lg">
                Save
            </button>
        </form>

        <div class="bg-gray-700 p-4 rounded-lg max-h-64 overflow-y-auto">
            <h2 class="text-lg font-semibold mb-2">Saved Data:</h2>
            <?php if (empty($messages)): ?>
                <p class="text-gray-400">No data yet.</p>
            <?php else: ?>
                <?php foreach ($messages as $msg): ?>
                    <div class="border-b border-gray-600 py-1">
                        <?php echo $msg; ?>
                    </div>
                <?php endforeach; ?>
            <?php endif; ?>
        </div>
    </div>

</body>
</html>