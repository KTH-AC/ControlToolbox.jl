"""
`clyap(A, Q)`

Compute the solution `X` to the discrete Lyapunov equation
`AX + XA' + Q = 0`.
"""
# TODO: Change code by SLICOT version
function clyap(A::StridedMatrix{T}, Q::StridedMatrix{T}) where {T}
  lhs = kron(speye(size(A)...), A) + kron(conj(A),speye(size(A)...))
  x = -lhs\reshape(Q, prod(size(Q)), 1)
  return reshape(x, size(Q))
end
clyap(A::StridedMatrix{T1}, Q::StridedMatrix{T2}) where {T1<:Real,T2<:Real} =
  clyap(float(A), float(Q))


"""
`dlyap(A, Q)`

Compute the solution `X` to the discrete Lyapunov equation
`AXA' - X + Q = 0`.
"""
# TODO: Change code by SLICOT version
function dlyap(A::StridedMatrix{T}, Q::StridedMatrix{T}) where {T}
  lhs = kron(conj(A), A)
  lhs = speye(size(lhs)...) - lhs
  x = lhs\reshape(Q, prod(size(Q)), 1)
  return reshape(x, size(Q))
end
dlyap(A::StridedMatrix{T1}, Q::StridedMatrix{T2}) where {T1<:Real,T2<:Real} =
  dlyap(float(A), float(Q))

lyap(A::StridedMatrix{T}, Q::StridedMatrix{T},::Type{Val{:cont}}) where {T} =
  clyap(A,Q)

lyap(A::StridedMatrix{T}, Q::StridedMatrix{T},::Type{Val{:disc}}) where {T} =
  dlyap(A,Q)
