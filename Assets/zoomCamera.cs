using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Cinemachine;
public class zoomCamera : MonoBehaviour
{
    private CinemachineVirtualCamera vc;
    [SerializeField]
    GameObject enemyModel;
    private void Awake()
    {
        vc = GameObject.Find("CM vcam1").GetComponent<CinemachineVirtualCamera>();

    }
    public void ZoomIn()
    {
        vc.LookAt =enemyModel.transform ;
        vc.m_Lens.FieldOfView -= 20;
    }
    public void ZoomOut()
    {
        vc.m_Lens.FieldOfView += 20;

        //vc.m_Lens.FieldOfView -= 40;
    }


}
