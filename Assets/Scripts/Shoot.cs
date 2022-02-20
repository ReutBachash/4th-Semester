using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class Shoot : MonoBehaviour
{
    public float Range = 1000;
    public float Force = 1000;
    private float _hitRange=2000;
    [SerializeField] private Camera mainCamera;
    [SerializeField] private LayerMask mouseColiderLayerMask;

    public event Action<EnemyIdentity> onEnemyDeath;


    // Update is called once per frame
    void Update()
    {
        if (Input.GetMouseButtonDown(0))
            RayShoot();
    }

    void RayShoot()
    {
        Ray ray = mainCamera.ScreenPointToRay(Input.mousePosition);
        if (Physics.Raycast(ray, out RaycastHit hit, _hitRange, mouseColiderLayerMask))
        {
            Debug.DrawLine(ray.origin, hit.point,Color.blue);
            if(hit.transform.CompareTag("Enemy"))
            {
                onEnemyDeath.Invoke(hit.transform.GetComponentInParent<EnemyIdentity>());
                //hit.transform.parent.GetComponentInChildren<Animator>().SetTrigger("Death");
                hit.transform.parent.GetComponentInParent<Animator>().SetTrigger("Death");
                hit.transform.parent.GetComponentInParent<DestroyObject>().DestroyMe(2f);
            }

        }
    }
}
