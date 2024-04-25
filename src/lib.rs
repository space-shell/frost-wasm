mod utils;

use wasm_bindgen::prelude::*;

use std::{collections::BTreeMap, io::Write, num::NonZeroU32};

use rand::RngCore;
use rand_chacha::ChaCha20Rng;
use schnorr_fun::fun::{
    marker::{EvenY, NonZero, Public, Secret, Zero},
    Point, Scalar,
};
use schnorr_fun::{
    frost::{self, FrostKey},
    musig::Nonce,
    Message, Signature,
};
use serde::{Deserialize, Serialize};
use serde_json::json;
use sha2::Digest;
use sha2::Sha256;

#[derive(Serialize, Deserialize)]
struct FrostKeyPair {
    frost_key: FrostKey<EvenY>,
    secret_share: Scalar,
    our_index: Scalar<Public>,
}

#[wasm_bindgen]
extern "C" {
    fn alert(s: &str);
}

#[wasm_bindgen]
pub fn greet() {
    let frost = frost::new_with_synthetic_nonces::<Sha256, rand::rngs::ThreadRng>();

    alert("Hello, wasm-frost!");
}
