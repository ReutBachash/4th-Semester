using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerHealth : MonoBehaviour
{
    [SerializeField] Material _healthBarMat;
    public float health = 100;
    // Start is called before the first frame update
    void Start()
    {

        _healthBarMat.SetFloat("_Health", health / 100);
    }

    public void DecreaseHealth()
    {
        health= health- 20;
        _healthBarMat.SetFloat("_Health", health/100);
    }
}
