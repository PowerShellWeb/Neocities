param()
if ($this.Domain) {
    "https://$($this.Domain)/"
}
elseif ($this.sitename) {
    "https://$($this.sitename).neocities.org/"
}
