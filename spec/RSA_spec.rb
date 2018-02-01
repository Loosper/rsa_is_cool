require "RSA"

# God save the queen:
# https://www.cs.drexel.edu/~introcs/Fa11/notes/10.1_Cryptography/RSA_Express_EncryptDecrypt.html
N = 899
E = 11
D = 611

describe RSA do
  let(:rsa_inst) { RSA.new(N, E, D) }

  context "generate random key pairs" do
    it "makes a random key pair" do
      p rsa_inst.new_key, RSA.new(N, E, D).new_key
      expect(rsa_inst.new_key).not_to eql(RSA.new(N, E, D).new_key)
    end
  end

  context "store values properly" do
    it "gets n" do
      expect(rsa_inst.n()).to eql(N)
    end

    it "gets e" do
      expect(rsa_inst.e()).to eql(E)
    end

    it "gets d" do
      expect(rsa_inst.d()).to eql(D)
    end
  end

  context "encrypting messages" do
    it "encrypts simple strings" do
      expect(rsa_inst.encrypt('w')).to eql([595])
    end

    it "encrypts long messages" do
      expect(rsa_inst.encrypt('Hello')).to eql([298, 8, 635, 635, 741])
    end
  end

  context "decrypting messages" do
    it "decrypts simple strings" do
      expect(rsa_inst.decrypt([595])).to eql('w')
    end

    it "decrypts long messages" do
      expect(rsa_inst.decrypt([298, 8, 635, 635, 741])).to eql('Hello')
    end
  end
end
