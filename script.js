let cypsd = false;
function cpys() {
  if(cypsd) return;
  cypsd = true;
  navigator.clipboard.writeText("loadstring(game:HttpGet(\"https://raw.githubusercontent.com/easyontop/scr/main/MainScript.lua\"))()");
  document.getElementById("cpys").innerText = "Copied to clipboard!";
  setTimeout(function() {
    document.getElementById("cpys").innerText = "Copy Script"
    cypsd = false;
  }, 1000);
}