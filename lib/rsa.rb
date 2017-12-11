class RSA
  def initialize n, e,d
    @n = n
    @e = e
    @d = d
  end
  # ported from python
  def egcd(a, b)
    if a == 0
      return b, 0, 1
    else
      g, y, x = egcd(b % a, a)
      return g, x - (b / a) * y, y
    end
  end

  def modinv(a, m)
    g, x, _ = egcd(a, m)
    if g != 1
      raise ArgumenError('modular inverse does not exist')
    else
      return x % m
    end
  end

  def new_key
    # we want them BIG
    p = 2 ^ rand(100..10000000000000) - 1
    q = 2 ^ rand(1000..100000000) - 1
    n = p * q
    tot = (p - 1) * (q - 1)
    e = nil

    # this makes a relaively random number
    (tot - 2).downto(2) do |num|
      if num.gcd(tot) == 1
        e = num
        break
      end
    end

    d = modinv(e, tot)
    return n, e, d
  end

  def n
    @n
  end

  def e
    @e
  end

  def d
    @d
  end

  def encrypt msg
    cypher = []
    msg.bytes.each do |byte|
      cypher << (byte ** @e) % @n
    end

    return cypher
  end

  def decrypt cypher
    msg = []
    cypher.each do |byte|
      msg << (byte ** @d) % @n
    end

    return msg.map {|let| let.chr}.join
  end
end
