# Sanity Theme for Unraid 6.6+

This theme is based on Dynamix White. I modified it to be more to my liking. I hope it is to yours too!

## What's been done

- Uses your system default font (ie: San Francisco, Segoe, Roboto, etc)
- Buttons are colored and easier to identify
- Top menu looks like familiar tabs
- Reduced overall size of fonts and some elements

## Installation

- SSH into your Unraid server
- Run `curl https://raw.githubusercontent.com/cmer/unraid-sanity/master/install.sh | sudo bash`
- Navigate to `http://your-unraid-ip/Settings/DisplaySettings` and select White as your Dynamix Color Theme.

### Persist changes after reboot

If you want to keep the Sanity theme after rebooting your server, simply run:

`echo "curl https://raw.githubusercontent.com/cmer/unraid-sanity/master/install.sh | sudo bash" >> /boot/config/go`

### Persist changes after reboot (without Internet)

If you'd rather not have your server execute a remote script on every reboot, you could simply clone the repo locally first.

```bash
# Save the remote repo locally
git clone https://github.com/cmer/unraid-sanity.git /mnt/user/sanity-theme

# Run this every time you want to fetch updates
cd /mnt/user/sanity-theme && git pull

# Persist theme across reboots
echo "/mnt/user/sanity-theme/install_local.sh" >> /boot/config/go
```


## Look and feel

![](screenshot.png?raw=true)
