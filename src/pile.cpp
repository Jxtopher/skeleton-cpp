#include "pile.h"

template <class TYPE>
Pile<TYPE>::Pile() {
    data = new TYPE[0];
    nbElementMax = 0;
    nbElement = 0;
    delta = 30;
}

template <class TYPE>
Pile<TYPE>::~Pile() {
    delete data;
}

template <class TYPE>
Pile<TYPE>::Pile(Pile const& p) {
    nbElementMax = p.nbElementMax;
    nbElement = p.nbElement;
    delta = p.delta;
    data = new TYPE[nbElementMax];
    for (unsigned int i = 0; i < nbElementMax; i++) {
        data[i] = p.data[i];
    }
}

template <class TYPE>
Pile<TYPE>& Pile<TYPE>::operator=(const Pile& p) {
    if (nbElementMax != p.nbElementMax)
        data = static_cast<TYPE*>(realloc(data, p.nbElementMax * sizeof(TYPE)));

    nbElementMax = p.nbElementMax;
    nbElement = p.nbElement;
    delta = p.delta;
    for (unsigned int i = 0; i < nbElementMax; i++) {
        data[i] = p.data[i];
    }
    return *this;
}

template <class TYPE>
bool Pile<TYPE>::operator==(const Pile& p) const {
    if (p.size() != size())
        return false;

    for (unsigned int i = 0; i < size(); i++) {
        if (p.data[i] != data[i])
            return false;
    }
    return true;
}

template <class TYPE>
bool Pile<TYPE>::operator!=(const Pile& p) const {
    return not(operator==(p));
}

template <class TYPE>
void Pile<TYPE>::push(TYPE element) {
    if (nbElement == nbElementMax) {
        nbElementMax += 10;
        data = static_cast<TYPE*>(realloc(data, nbElementMax * sizeof(TYPE)));
        data[nbElement] = element;
        nbElement++;
    } else {
        data[nbElement] = element;
        nbElement++;
    }
}

template <class TYPE>
TYPE Pile<TYPE>::pop() {
    if (nbElement == 0) {
        assert(nbElement != 0);
    }
    if (delta < (nbElementMax - nbElement)) {
        // Liberation de la mémoire
        nbElementMax -= 10;
        data = static_cast<TYPE*>(realloc(data, nbElementMax * sizeof(TYPE)));
    }
    nbElement--;
    return data[nbElement];
}

template <class TYPE>
bool Pile<TYPE>::isEmpty() const {
    return nbElement == 0;
}

template <class TYPE>
unsigned int Pile<TYPE>::size() const {
    return nbElement;
}

template class Pile<unsigned int>;
