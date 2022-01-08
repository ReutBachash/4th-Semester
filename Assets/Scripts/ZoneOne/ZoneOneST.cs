using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ZoneOneST : MonoBehaviour
{
    [SerializeField] Animator EnemyOne;
    [SerializeField] Animator EnemyTwo;
    [SerializeField] Animator EnemyThree;
    [SerializeField] Animator EnemyFour;

    private bool TriggerOne;

    public void OnTriggerEnter(Collider collider)
    {
        if (this.gameObject.CompareTag("ZoneOne"))
        {
            ZoneOne();
        }
    }

    private void ZoneOne()
    {
        TriggerOne = true;
    }

}

