from base64 import b64encode
from nacl import encoding, public

def encrypt(public_key: str, secret_value: str) -> str:
  """Encrypt a Unicode string using the public key."""
  public_key = public.PublicKey(public_key.encode("utf-8"), encoding.Base64Encoder())
  sealed_box = public.SealedBox(public_key)
  encrypted = sealed_box.encrypt(secret_value.encode("utf-8"))
  decoded = b64encode(encrypted).decode("utf-8")
  return decoded

encrypt("aSBhbSBrcmlzaG5hZGhhcwo=", "aSBhbSBrcmlzaG5hZGhhcwo=")

