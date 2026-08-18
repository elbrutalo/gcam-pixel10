.class public Lsgcam/patzi/Bye;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# static fields
.field private static h:Landroid/os/Handler;

.field private static r:Lsgcam/patzi/Bye;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static handler()Landroid/os/Handler;
    .locals 2

    sget-object v0, Lsgcam/patzi/Bye;->h:Landroid/os/Handler;

    if-nez v0, :cond_have

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lsgcam/patzi/Bye;->h:Landroid/os/Handler;

    :cond_have
    sget-object v0, Lsgcam/patzi/Bye;->h:Landroid/os/Handler;

    return-object v0
.end method

.method private static runnable()Lsgcam/patzi/Bye;
    .locals 1

    sget-object v0, Lsgcam/patzi/Bye;->r:Lsgcam/patzi/Bye;

    if-nez v0, :cond_have

    new-instance v0, Lsgcam/patzi/Bye;

    invoke-direct {v0}, Lsgcam/patzi/Bye;-><init>()V

    sput-object v0, Lsgcam/patzi/Bye;->r:Lsgcam/patzi/Bye;

    :cond_have
    sget-object v0, Lsgcam/patzi/Bye;->r:Lsgcam/patzi/Bye;

    return-object v0
.end method

.method public static schedule()V
    .locals 4

    invoke-static {}, Lsgcam/patzi/Bye;->handler()Landroid/os/Handler;

    move-result-object v0

    invoke-static {}, Lsgcam/patzi/Bye;->runnable()Lsgcam/patzi/Bye;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    const-wide/16 v2, 0x5dc

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method public static cancel()V
    .locals 2

    invoke-static {}, Lsgcam/patzi/Bye;->handler()Landroid/os/Handler;

    move-result-object v0

    invoke-static {}, Lsgcam/patzi/Bye;->runnable()Lsgcam/patzi/Bye;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    new-instance v0, Landroid/app/ActivityManager$RunningAppProcessInfo;

    invoke-direct {v0}, Landroid/app/ActivityManager$RunningAppProcessInfo;-><init>()V

    invoke-static {v0}, Landroid/app/ActivityManager;->getMyMemoryState(Landroid/app/ActivityManager$RunningAppProcessInfo;)V

    iget v1, v0, Landroid/app/ActivityManager$RunningAppProcessInfo;->importance:I

    # IMPORTANCE_VISIBLE ist 200. Alles darunter heisst: noch sichtbar,
    # etwa weil die Einstellungen offen sind - dann nicht beenden.
    const/16 v2, 0xc8

    if-gt v1, v2, :cond_kill

    return-void

    :cond_kill
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v1

    invoke-static {v1}, Landroid/os/Process;->killProcess(I)V

    return-void
.end method
